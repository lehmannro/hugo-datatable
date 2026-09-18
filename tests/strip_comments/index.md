---
note: This file has been formatted with mdformat.
---

{{< datatable-data strip=true >}}

<!--
- number: 1
  meaning: First number
- number: 2
  meaning: Second number
-->

{{< /datatable-data >}}

{{< datatable headers="Numbers" >}}

<td>{{ .number }} (<em>{{ .meaning }}</em>)</td>
{{< /datatable >}}
