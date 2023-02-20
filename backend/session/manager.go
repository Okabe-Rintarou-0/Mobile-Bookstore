package session

import (
	"bookstore-backend/config"
	"fmt"
	"net/http"
	"net/url"
	"sync"
	"time"
)

var Manager *DefaultManager

type DefaultManager struct {
	cookieName  string
	lock        sync.Mutex
	provider    Provider
	maxLifetime uint64
}

func init() {
	maxLifetime := config.Global.Session.Lifetime
	fmt.Printf("%+v\n", config.Global)
	RegisterProvider("redis", &RedisProvider{maxLifetime: maxLifetime})
	var err error
	Manager, err = NewManager("redis", "book-store-sid", maxLifetime)
	if err != nil {
		panic(err)
	}
}

func NewManager(provideName, cookieName string, maxLifetime uint64) (*DefaultManager, error) {
	provider, ok := providers[provideName]
	if !ok {
		return nil, fmt.Errorf("session: unknown provide %q (forgotten import?)", provideName)
	}
	return &DefaultManager{provider: provider, cookieName: cookieName, maxLifetime: maxLifetime}, nil
}

func (m *DefaultManager) sid(r *http.Request) string {
	if cookie, err := r.Cookie(m.cookieName); err == nil {
		return cookie.Value
	}
	return ""
}

func (m *DefaultManager) CheckSession(r *http.Request) bool {
	if sid := m.sid(r); sid != "" {
		session, err := m.provider.GetSession(sid)
		return session != nil && err == nil
	}
	return false
}

func (m *DefaultManager) NewSession(w http.ResponseWriter, r *http.Request) (session Session, err error) {
	session, err = m.provider.CreateSession()
	if err == nil {
		cookie := http.Cookie{
			Name: m.cookieName, Value: url.QueryEscape(session.Id()), Path: "/", HttpOnly: true, MaxAge: int(m.maxLifetime),
		}
		http.SetCookie(w, &cookie)
	}
	return
}

func (m *DefaultManager) DestroySession(w http.ResponseWriter, r *http.Request) {
	if sid := m.sid(r); sid != "" {
		err := m.provider.DestroySession(sid)
		if err != nil {
			return
		}
		expiration := time.Now()
		cookie := http.Cookie{Name: m.cookieName, Path: "/", HttpOnly: true, Expires: expiration, MaxAge: -1}
		http.SetCookie(w, &cookie)
	}
}
