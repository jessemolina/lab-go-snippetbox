package main

import (
	"flag"
	"log"
	"net/http"
	"os"
)

// application dependencies
type application struct {
	errorLog	*log.Logger
	infoLog 	*log.Logger
}

func main() {
	// define cli flags
	addr := flag.String("addr", ":4000", "HTTP network address")
	flag.Parse()

	// custom loggers
	infoLog := log.New(os.Stdout, "INFO\t", log.Ldate|log.Ltime)
	errorLog := log.New(os.Stdout, "ERROR\t", log.Ldate|log.Ltime|log.Lshortfile)

	// initialize app from struct
	app := &application{
		errorLog: 	errorLog,
		infoLog: 	infoLog,
	}


	// overwrite default server to use custom errorLog
	srv := &http.Server{
		Addr: 		*addr,
		ErrorLog: 	errorLog,
		Handler: 	app.routes(),
	}

	// listen and server on 4000
	infoLog.Printf("Starting server on %s", *addr)
	err := srv.ListenAndServe()
	if err != nil {
		errorLog.Fatal(err)
	}
}
