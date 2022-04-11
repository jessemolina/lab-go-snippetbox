package main

import (
	"flag"
	"log"
	"net/http"
)


func main() {
	// define cli flags
	addr := flag.String("addr", ":4000", "HTTP network address")
	flag.Parse()

	// initialize new servemux
	mux := http.NewServeMux()

	// register the home function as the hanlder for root url
	mux.HandleFunc("/", home)
	mux.HandleFunc("/snippet", showSnippet)
	mux.HandleFunc("/snippet/create", createSnippet)

	// handle static file directory
	fileServer := http.FileServer(http.Dir("./ui/static"))
	mux.Handle("/static/", http.StripPrefix("/static", fileServer))

	// listen and server on 4000
	log.Printf("Starting server on %s", *addr)
	err := http.ListenAndServe(*addr, mux)
	if err != nil {
		log.Fatal(err)
	}
}
