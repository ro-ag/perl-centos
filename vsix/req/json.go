package req

type FilterType int64
type AssetTypes string

type Query struct {
	Filters    []Filter     `json:"filters"`
	AssetTypes []AssetTypes `json:"assetTypes"`
	Flags      Flags        `json:"flags"`
}

type Filter struct {
	Criteria   []Criterion `json:"criteria"`
	PageNumber int64       `json:"pageNumber"`
	PageSize   int64       `json:"pageSize"`
	SortBy     int64       `json:"sortBy"`
	SortOrder  int64       `json:"sortOrder"`
}

type Criterion struct {
	FilterType FilterType `json:"filterType"`
	Value      string     `json:"value"`
}

const (
	Tag              FilterType = 1
	ExtensionId      FilterType = 4
	Category         FilterType = 5
	ExtensionName    FilterType = 7
	Target           FilterType = 8
	Featured         FilterType = 9
	SearchText       FilterType = 10
	ExcludeWithFlags FilterType = 12
)
const (
	Icon       AssetTypes = "Microsoft.VisualStudio.Services.Icons.Default"
	Details    AssetTypes = "Microsoft.VisualStudio.Services.Content.Details"
	Changelog  AssetTypes = "Microsoft.VisualStudio.Services.Content.Changelog"
	Manifest   AssetTypes = "Microsoft.VisualStudio.Code.Manifest"
	VSIX       AssetTypes = "Microsoft.VisualStudio.Services.VSIXPackage"
	License    AssetTypes = "Microsoft.VisualStudio.Services.Content.License"
	Repository AssetTypes = "Microsoft.VisualStudio.Services.Links.Source"
)

type Flags int64

const (
	// None is used to retrieve only the basic extension details.
	None Flags = 0x0

	// IncludeVersions will return version information for extensions returned
	IncludeVersions Flags = 0x1

	// IncludeFiles will return information about which files were found
	// within the extension that were stored independent of the manifest.
	// When asking for files, versions will be included as well since files
	// are returned as a property of the versions.
	//
	// These files can be retrieved using the path to the file without
	// requiring the entire manifest be downloaded.
	IncludeFiles Flags = 0x2

	// IncludeCategoryAndTags Include the Categories and Tags that were added to the extension definition.
	IncludeCategoryAndTags Flags = 0x4

	// IncludeSharedAccounts Include the details about which accounts the extension has been shared
	// with if the extension is a private extension.
	IncludeSharedAccounts Flags = 0x8

	// IncludeVersionProperties Include properties associated with versions of the extension
	IncludeVersionProperties Flags = 0x10

	// ExcludeNonValidated Excluding non-validated extensions will remove any extension versions that
	// either are in the process of being validated or have failed validation.
	ExcludeNonValidated Flags = 0x20

	// IncludeInstallationTargets Include the set of installation targets the extension has requested.
	IncludeInstallationTargets Flags = 0x40

	// IncludeAssetUri Include the base uri for assets of this extension
	IncludeAssetUri Flags = 0x80

	// IncludeStatistics Include the statistics associated with this extension
	IncludeStatistics Flags = 0x100

	// IncludeLatestVersionOnly When retrieving versions from a query, only include the latest
	// version of the extensions that matched. This is useful when the
	// caller doesn't need all the published versions. It will save a
	// significant size in the returned payload.
	IncludeLatestVersionOnly Flags = 0x200

	// Unpublished This flag switches the asset uri to use GetAssetByName instead of CDN
	// When this is used, values of base asset uri and base asset uri fallback are switched
	// When this is used, source of asset files are pointed to Gallery service always even if CDN is available
	Unpublished Flags = 0x1000

	// IncludeNameConflictInfo Include the details if an extension is in conflict list or not
	IncludeNameConflictInfo Flags = 0x8000
)
