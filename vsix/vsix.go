package main

import (
	"encoding/json"
	"fmt"
	"io"
	"log"
	"net/http"
	"vsix/req"
	"vsix/res"
)

const MarketPlaceAPI = "https://marketplace.visualstudio.com/_apis/public/gallery/extensionquery?api-version=5.1-preview"

func main() {

	// nice too to test
	// https://reqbin.com
	data := req.NewQuery("golang.Go", req.IncludeVersions|req.ExcludeNonValidated|req.IncludeFiles|req.IncludeVersionProperties)

	fmt.Println("Hello")
	response, err := http.Post(MarketPlaceAPI, "application/json", data.Reader())
	if err != nil {
		log.Fatal(err)
	} else {
		defer func(Body io.ReadCloser) {
			err := Body.Close()
			if err != nil {
				log.Println(err)
			}
		}(response.Body)
	}

	var given res.JSON
	if response.StatusCode == http.StatusOK {
		log.Println("STATUS: ", response.Status)
		bodyBytes, err := io.ReadAll(response.Body)
		if err != nil {
			log.Fatal(err)
		}
		//} else {
		//	log.Printf(string(bodyBytes))
		//}

		if err = json.Unmarshal(bodyBytes, &given); err != err {
			log.Fatal("Error Unmarshall: ", err)
		}

	} else {
		log.Fatal("STATUS: ", response.Status)
	}

	DownloadFile(given.VSIXPackageURL(), "./"+given.FileName())
}
