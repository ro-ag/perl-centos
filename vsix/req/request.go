package req

import (
	"bytes"
	"encoding/json"
	"log"
)

func NewQuery(extensionName string, flags Flags) Query {
	data := Query{
		Filters: []Filter{
			{
				Criteria: []Criterion{
					{
						FilterType: Target,
						Value:      "Microsoft.VisualStudio.Code",
					},
					{
						FilterType: ExtensionName,
						Value:      extensionName,
					},
				},
				PageNumber: 1,
				PageSize:   10,
				SortBy:     0,
				SortOrder:  0,
			},
		},
		AssetTypes: []AssetTypes{VSIX},
		Flags:      flags,
	}
	return data
}

func (q *Query) Json() ([]byte, error) {
	return json.Marshal(*q)
}

func (q *Query) Buffer() (*bytes.Buffer, error) {
	if buf, err := q.Json(); err != nil {
		return nil, err
	} else {
		return bytes.NewBuffer(buf), nil
	}
}

func (q *Query) Reader() *bytes.Buffer {
	buf, err := q.Json()
	if err != nil {
		log.Fatal("Request JSON Error", err)
	}
	return bytes.NewBuffer(buf)
}
