package req

type Query struct {
	Filters    []Filter `json:"filters"`
	AssetTypes []string `json:"assetTypes"`
	Flags      int64    `json:"flags"`
}

type Filter struct {
	Criteria   []Criterion `json:"criteria"`
	PageNumber int64       `json:"pageNumber"`
	PageSize   int64       `json:"pageSize"`
	SortBy     int64       `json:"sortBy"`
	SortOrder  int64       `json:"sortOrder"`
}

type Criterion struct {
	FilterType int64  `json:"filterType"`
	Value      string `json:"value"`
}
