---
numbers:
- number: 10
  meaning: Our base
- number: 60
  meaning: Mayan base
---

{{< datatable param="numbers" headers="Number,Meaning" >}}
<td>{{ .number }}</td>
<td><em>{{ .meaning }}</em></td>
{{< /datatable >}}
