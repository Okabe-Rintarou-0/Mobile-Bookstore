package session

import (
	"bookstore-backend/db/redis"
	"context"
	"fmt"
	"sync"
	"time"
)

type Session interface {
	Init(maxLifetime uint64) error
	Set(key string, value interface{}) error
	Get(key string) (interface{}, error)
	Del(key string) error
	Id() string
}

type DefaultSession struct {
	id    string
	lock  sync.RWMutex
	store map[string]interface{}
	since time.Time
}

func (s *DefaultSession) Set(key string, value interface{}) error {
	s.lock.Lock()
	defer s.lock.Unlock()
	s.store[key] = value
	return nil
}

func (s *DefaultSession) Get(key string) (interface{}, error) {
	s.lock.RLock()
	defer s.lock.RUnlock()
	if value, ok := s.store[key]; ok {
		return value, nil
	} else {
		return nil, fmt.Errorf("unknown key %s", key)
	}
}

func (s *DefaultSession) Del(key string) error {
	s.lock.Lock()
	defer s.lock.Unlock()
	if _, ok := s.store[key]; ok {
		delete(s.store, key)
		return nil
	} else {
		return fmt.Errorf("unknown key %s", key)
	}
}

func (s *DefaultSession) Id() string {
	return s.id
}

func (s *DefaultSession) Init(_ uint64) error {
	return nil
}

type RedisSession struct {
	id string
}

func (s *RedisSession) Set(key string, value interface{}) error {
	ctx := context.Background()
	cmd := redis.Cli.HSet(ctx, s.id, key, value)
	_, err := cmd.Result()
	return err
}

func (s *RedisSession) Get(key string) (interface{}, error) {
	ctx := context.Background()
	cmd := redis.Cli.HGet(ctx, s.id, key)
	if val, err := cmd.Result(); err == nil {
		return val, err
	} else {
		return nil, err
	}
}

func (s *RedisSession) Del(key string) error {
	ctx := context.Background()
	cmd := redis.Cli.HDel(ctx, s.id, key)
	return cmd.Err()
}

func (s *RedisSession) Id() string {
	return s.id
}

func (s *RedisSession) Init(maxLifetime uint64) error {
	ctx := context.Background()
	cmd := redis.Cli.Expire(ctx, s.id, time.Second*time.Duration(maxLifetime))
	return cmd.Err()
}

func (s *RedisSession) Since() (time.Time, error) {
	ctx := context.Background()
	cmd := redis.Cli.HGet(ctx, s.id, "since")
	if err := cmd.Err(); err == nil {
		var t time.Time
		t, err = time.Parse(time.Layout, cmd.String())
		return t, err
	} else {
		return time.Time{}, err
	}
}
