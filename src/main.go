package main

import (
	"encoding/json"
	"strings"

	"github.com/evanw/esbuild/pkg/api"
)

import "C"

type BuildResponse struct {
	Status		int
    Data		[]api.Message
	Metadata	string
}

//export build
func build(entry *C.char, out *C.char, externals *C.char) *C.char {
	// This may be incomplete
	bunModules := []string{"bun:jsc", "bun:ffi", "bun:sqlite", "bun:wrap", "bun:main"}
	extString := C.GoString(externals)
	extSlice := strings.Split(extString, ",");
	allExternals := append(bunModules, extSlice...);

	result := api.Build(api.BuildOptions{
		EntryPoints: []string{C.GoString(entry)},
		Outfile:     C.GoString(out),
		Write:       true,
		Bundle:		 true,
		Platform:    api.PlatformNode,
		External:	 allExternals,
		Format:		 api.FormatESModule,
		TreeShaking: api.TreeShakingTrue,
		MinifyWhitespace:  true,
		MinifyIdentifiers: true,
		MinifySyntax:      true,
		Metafile: true,
		LogOverride: map[string]api.LogLevel{
			"unsupported-dynamic-import": api.LogLevelWarning,
			"unsupported-require-call": api.LogLevelWarning,
		},
	})
	
	if len(result.Errors) > 0 {
		returnjson := BuildResponse{Status: -1, Metadata: result.Metafile}
		returnjson.Data = result.Errors
		returnenc, _ := json.Marshal(returnjson)
		
		return C.CString(string(returnenc));
	}else {
		returnjson := BuildResponse{Status: 1, Metadata: result.Metafile}
		if len(result.Warnings) > 0 {
			returnjson.Status = 0
			returnjson.Data = result.Warnings
		}
		returnenc, _ := json.Marshal(returnjson)

		return C.CString(string(returnenc));
	}
}

func main() {
	// result := C.GoString(build(C.CString("test/myapp/index.js"), C.CString("bundle.js"), C.CString("")));
	// println(result)
}