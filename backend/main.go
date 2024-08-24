package main

import (
	"context"
	"fmt"
	"io"
	"net/http"
	"net/url"
	"os"

	"github.com/redis/go-redis/v9"
)

var (
	rdb *redis.Client
	ctx = context.Background()
)

func main() {
	fmt.Println("connecting to ", os.Getenv("REDIS_URL"))
	rdb = redis.NewClient(&redis.Options{
		Addr:     os.Getenv("REDIS_URL"),
		Password: "",
		DB:       0,
	})
	fmt.Println(rdb.Ping(ctx).Result())

	port := os.Getenv("PORT")
	if port == "" {
		os.Exit(-1)
	}

	http.HandleFunc("/get", get)
	http.HandleFunc("/set", put)

	http.ListenAndServe(port, nil)
}

func redisGet(key string) string {
	v, _ := rdb.Get(ctx, key).Result()

	fmt.Printf("get %s => %s\n", key, v)
	return v
}

func redisSet(key, v string) {
	fmt.Printf("set %s to %s\n", key, v)
	rdb.Set(ctx, key, v, 0)
}

func get(w http.ResponseWriter, r *http.Request) {
	enableCors(&w)
	value := redisGet("key")
	io.WriteString(w, getResp(value))
}

func put(w http.ResponseWriter, r *http.Request) {
	enableCors(&w)
	params, _ := url.ParseQuery(r.URL.RawQuery)
	redisSet("key", params.Get("v"))
	io.WriteString(w, getResp("ok"))
}

// helpers

func getResp(message string) string {
	return fmt.Sprintf("{\"message\": \"%s\"}", message)
}
func enableCors(w *http.ResponseWriter) {
	(*w).Header().Set("Access-Control-Allow-Origin", "*")
}
