---
---

{{< datatable file="local.toml" root="pets" headers="Category,Name" >}}
<td>{{ .category }}</td>
<td>{{ .name | upper }}</td>
{{< /datatable >}}

{{< datatable file="local.toml" root="strays.pet" headers="Name" >}}
<td>{{ .name }}</td>
{{< /datatable >}}
