package main

import (
	"github.com/gorilla/mux"
	"log"
	"net/http"
)

func main() {
	log.Println("Starting server")
	myRouter := mux.NewRouter().StrictSlash(true)
	myRouter.HandleFunc("/", serveHome).Methods("GET")
	log.Fatal(http.ListenAndServe(":8080", myRouter))
}

func serveHome(w http.ResponseWriter, r *http.Request) {
	w.WriteHeader(200)
	_, err := w.Write([]byte("Hello via ssl :)"))
	if err != nil {
		return
	}
}
