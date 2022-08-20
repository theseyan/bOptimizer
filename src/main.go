package main

import "io/ioutil"
import "github.com/theseyan/boptimizer/pkg/api"
import "os"

func main() {
  ioutil.WriteFile("in.ts", []byte("let x: number = 1"), 0644)

  result := api.Build(api.BuildOptions{
    EntryPoints: []string{"in.ts"},
    Outfile:     "out.js",
    Write:       true,
  })

  if len(result.Errors) > 0 {
    os.Exit(1)
  }
}