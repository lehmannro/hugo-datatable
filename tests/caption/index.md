---
---

{{< datatable-data >}}
- number: 42
  meaning: Answer
- number: 3.14
  meaning: Pi
{{< /datatable-data >}}

{{< datatable headers="Number" caption="Interesting numbers" >}}
<td>{{ .number }} (<em>{{ .meaning }}</em>)</td>
{{< /datatable >}}
