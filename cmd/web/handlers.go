package main

import (
	"fmt"
	"net/http"
	"strconv"
	"text/template"
)

// define a home hanlder function
func (app *application) home(w http.ResponseWriter, r *http.Request) {
	// restrict the url from using catch-all pattern
	if r.URL.Path != "/" {
		app.notFound(w)
		return
	}

	// slice collection of templates to server
	files := []string{
		"./ui/html/home.page.tmpl",
		"./ui/html/base.layout.tmpl",
		"./ui/html/footer.partial.tmpl",
	}

	// create template definitions
	ts, err := template.ParseFiles(files...)
	if err != nil {
		app.serverError(w, err)
		return
	}

	err = ts.Execute(w, nil)
	if err != nil {
		app.serverError(w, err)
	}
}

// show specific snippet
func (app *application) showSnippet(w http.ResponseWriter, r *http.Request){
	// enforce positive value snippet id
	id, err := strconv.Atoi(r.URL.Query().Get("id"))
	if err != nil || id < 1 {
		app.notFound(w)
		return
	}
	fmt.Fprintf(w, "show snippet with ID %d", id)
}

// create a snippet
func (app *application) createSnippet(w http.ResponseWriter, r *http.Request){
	// enforce http post method
	if r.Method != http.MethodPost {
		w.Header().Set("Allow", http.MethodPost)
		app.clientError(w, http.StatusMethodNotAllowed)
		return
	}
	w.Write([]byte("create a snippet"))
}
