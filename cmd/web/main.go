package main

import (
	"fmt"
	"log"
	"net/http"
	"strconv"
)

// define a home hanlder function
func home(w http.ResponseWriter, r *http.Request) {
	if r.URL.Path != "/" {
		http.NotFound(w, r)
		return
	}
	w.Write([]byte("Hello Snippet!"))
}

// show specific snippet
func showSnippet(w http.ResponseWriter, r *http.Request){
	id, err := strconv.Atoi(r.URL.Query().Get("id"))
	if err != nil || id < 1 {
		http.NotFound(w, r)
		return
	}
	fmt.Fprintf(w, "show snippet with ID %d", id)
}

// create a snippet
func createSnippet(w http.ResponseWriter, r *http.Request){
	if r.Method != http.MethodPost {
		w.Header().Set("Allow", http.MethodPost)
		http.Error(w, "method not allowed", 405)
		return
	}
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
