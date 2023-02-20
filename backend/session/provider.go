package session

import (
	"bookstore-backend/db/redis"
	"context"
	"fmt"
	"github.com/google/uuid"
	"time"
)

var providers = make(map[string]Provider)

func RegisterProvider(name string, provider Provider) {
	if provider == nil {
		panic("session: Register provider is nil")
	}
	if _, dup := providers[name]; dup {
		panic("session: Register called twice for provider " + name)
	}
	providers[name] = provider
}

type Provider interface {
	CreateSession() (Session, error)
	GetSession(id string) (session Session, err error)
	DestroySession(id string) error
}

type RedisProvider struct {
	maxLifetime uint64
}

func (r *RedisProvider) CreateSession() (Session, error) {
	var (
		session = RedisSession{
			id: uuid.NewString(),
		}
		err error
	)

	fmt.Printf("set expire time: %d\n", r.maxLifetime)
	if err = session.Init(r.maxLifetime); err != nil {
		return nil, err
	}

	if err = session.Set("since", time.Now().String()); err == nil {
		return &session, nil
	} else {
		return nil, err
	}
}

func (r *RedisProvider) GetSession(id string) (Session, error) {
	ctx := context.Background()
	cmd := redis.Cli.Exists(ctx, id)
	if value, err := cmd.Uint64(); err == nil {
		if value == 1 {
			return &RedisSession{id: id}, nil
		} else {
			return nil, nil
		}
	} else {
		return nil, err
	}
}

func (r *RedisProvider) DestroySession(id string) error {
	ctx := context.Background()
	cmd := redis.Cli.Del(ctx, id)
	if _, err := cmd.Uint64(); err == nil {
		return nil
	} else {
		return err
	}
}
