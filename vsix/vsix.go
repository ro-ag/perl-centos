package main

import (
	"bytes"
	"encoding/json"
	"fmt"
	"io"
	"log"
	"net/http"
	"os"
	"path"
	"strconv"
	"time"
	"vsix/req"
	"vsix/res"
)

func main() {
	data := req.NewQuery("ms-python.python")

	fmt.Println("Hello")
	response, err := http.Post("https://marketplace.visualstudio.com/_apis/public/gallery/extensionquery?api-version=5.1-preview", "application/json", data.Reader())
	if err != nil {
		log.Fatal(err)
	}

	var given res.JSON
	if err := json.NewDecoder(response.Body).Decode(&given); err != nil {
		log.Fatal("Error Unmarshall: ", err)
	}

	fmt.Printf("%+v\n", given.VSIXPackageURL())
	fmt.Println(response.Status)
}

func DownloadFile(url string, dest string) {

	file := path.Base(url)

	log.Printf("Downloading file %s from %s\n", file, url)

	var path bytes.Buffer
	path.WriteString(dest)

	start := time.Now()

	out, err := os.Create(path.String())

	if err != nil {
		fmt.Println(path.String())
		panic(err)
	}

	defer out.Close()

	headResp, err := http.Head(url)

	if err != nil {
		panic(err)
	}

	defer headResp.Body.Close()

	size, err := strconv.Atoi(headResp.Header.Get("Content-Length"))

	if err != nil {
		panic(err)
	}

	done := make(chan int64)

	go PrintDownloadPercent(done, path.String(), int64(size))

	resp, err := http.Get(url)

	if err != nil {
		panic(err)
	}

	defer resp.Body.Close()

	n, err := io.Copy(out, resp.Body)

	if err != nil {
		panic(err)
	}

	done <- n

	elapsed := time.Since(start)
	log.Printf("Download completed in %s", elapsed)
}
