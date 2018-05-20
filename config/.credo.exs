%{
  configs: [
    %{
      name: "default",
      files: %{
        included: ["lib/"],
        excluded: []
      },
      checks: [
        {Credo.Check.Refactor.CyclomaticComplexity, max_complexity: 12},
        {Credo.Check.Readability.ModuleDoc, false},
        {Credo.Check.Consistency.TabsOrSpaces},
      ]
    }
  ]
}
