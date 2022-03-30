package main

import (
	"log"
	"net/http"
)

// define a home hanlder function
func home(w http.ResponseWriter, r *http.Request) {
	w.Header()
	w.Write([]byte("Hello Snippet!"))
}

// show specific snippet
func showSnippet(w http.ResponseWriter, r *http.Request){
	w.Write([]byte("show specific snippet"))
}

// create a snippet
func createSnippet(w http.ResponseWriter, r *http.Request){
	w.Write([]byte("create a snippet"))
}

func main() {
	// initialize new servemux
	mux := http.NewServeMux()

	// register the home function as the hanlder for root url
	mux.HandleFunc("/", home)
	mux.HandleFunc("/snippet", showSnippet)
	mux.HandleFunc("/snippet/create", createSnippet)

	// listen and server on 4000
	log.Println("Starting server on :4000")
	err := http.ListenAndServe(":4000", mux)
	if err != nil {
		log.Fatal(err)
	}
}