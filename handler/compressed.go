package handler

import (
	"github.com/gin-gonic/gin"
	"net/http"
	"strconv"
	"strings"
)

func Result () gin.HandlerFunc {
	return func(c *gin.Context) {
		message := c.Query("message")
		if message == "" {
			c.String(http.StatusNotAcceptable, "Incorrect Query")
		} else {
			c.String(http.StatusOK, compressed(message))
		}
	}
}


func compressed(message string) string {
	processMsg := strings.Split(message,"")
	compressedMsg := ""

	for i := 0; i < len(message); i++ {
		count := 1
		for ;i < len(message) - 1; {
			if processMsg[i] == processMsg[i + 1] {
				count++
				i++
			} else {
				break
			}
		}
		if count == 1 {
			compressedMsg = compressedMsg + processMsg[i]
		} else {
			compressedMsg = compressedMsg + processMsg[i] + strconv.Itoa(count)
		}
	}
	return compressedMsg
}