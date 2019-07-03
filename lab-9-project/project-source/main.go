package main

import (
	"fmt"
	"net/http"
	"os"
)

func welcome(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "<html><h2> Congratulations! You successfully deployed a binary with the exec driver </h2></html>")
}

func main() {
	port := os.Getenv("NOMAD_PORT_web")
	http.HandleFunc("/", welcome)
	http.ListenAndServe(fmt.Sprintf(":%s", port), nil)
}
