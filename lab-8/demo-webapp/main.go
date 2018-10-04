package main

import (
	"fmt"
	"html/template"
	"net/http"
	"os"
)

// Environment variables NODE_IP and PORT must be set or passed in

// Pick the version you want to display and the color you wish to display
// it in
var version = 3
var color = "green"

// HTML files that need to be parsed
var files = []string{"index.html"}

var t = template.Must(template.ParseFiles(files...))

type Intro struct {
	Version int
	Color   string
	Node    string
}

func giveIntro(w http.ResponseWriter, r *http.Request) {
	intro := Intro{version, color, os.Getenv("NODE_IP")}
	t.Execute(w, intro)
}

func main() {
	port := os.Getenv("PORT")
	mux := http.NewServeMux()
	server := &http.Server{
		Addr:    fmt.Sprintf("0.0.0.0:%v", port),
		Handler: mux,
	}
	mux.HandleFunc("/", giveIntro)
	server.ListenAndServe()
}
