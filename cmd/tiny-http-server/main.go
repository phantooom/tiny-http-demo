package main

import (
	"os"
	"strconv"
	"time"

	"github.com/gin-gonic/gin"
)

func main() {
	r := gin.Default()
	r.GET("/ping", func(c *gin.Context) {
		waitSecond := c.DefaultQuery("wait", "1")
		waitSecondInt, _ := strconv.Atoi(waitSecond)
		// 失败使用1s
		if waitSecondInt == 0 {
			waitSecondInt = 1
		}
		time.Sleep(time.Duration(waitSecondInt) * time.Second)
		code := c.DefaultQuery("code", "200")
		codeInt, _ := strconv.Atoi(code)
		// 解析失败用200
		if codeInt == 0 {
			codeInt = 200
		}
		hostname, _ := os.Hostname()
		c.JSON(codeInt, gin.H{
			"message": hostname,
			"header":  c.Request.Header,
		})
	})
	r.Run()
}
