package main

import (
	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
	"net/http"
)

func main() {
	e := echo.New()

	e.Use(middleware.Logger())
	e.Use(middleware.Recover())

	e.GET("/api/poroscope", func (ctx echo.Context) error {
		return ctx.JSON(http.StatusOK, "Hello world")
	})

	e.Logger.Fatal(e.Start(":8080"))
}
