package main

import (
	"encoding/json"
	"github.com/gorilla/mux"
	"log"
	"net/http"
)

func GetHoroscope(w http.ResponseWriter, r *http.Request)  {
	json.NewEncoder(w).Encode("hello world")
}

func main() {
	router :=  mux.NewRouter()

	router.HandleFunc("/api/poroscope", GetHoroscope).Methods("GET")
	log.Fatal(http.ListenAndServe(":8080", router))
}
