package main

import (
	"database/sql"
	"fmt"
	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
	_ "github.com/lib/pq"
	"net/http"
	"os"
)

var (
	dbUser = os.Getenv("POSTGRES_USER")
	dbPwd = os.Getenv("POSTGRES_PWD")
	dbName = os.Getenv("POSTGRES_DB")
)

type Horoscope struct {
	Id string
	Content string
}

func checkErr(err error) {
	if err != nil {
		panic(err)
	}
}

func setupDB() *sql.DB {
	dbInfo := fmt.Sprintf("user=%s password=%s dbname=%s sslmode=disable", dbUser, dbPwd, dbName)
	db, err := sql.Open("postgres", dbInfo)
	checkErr(err)
	return db
}

func main() {
	e := echo.New()

	e.Use(middleware.Logger())
	e.Use(middleware.Recover())

	e.GET("/api/poroscope", func (ctx echo.Context) error {
		db := setupDB()
		rows, err := db.Query("SELECT * FROM horoscope")
		checkErr(err)

		return ctx.JSON(http.StatusOK, rows)
	})

	e.Logger.Fatal(e.Start(":8080"))
}
