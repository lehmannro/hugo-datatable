---
---
{{< datatable-head >}}
<td colspan=2>Category-name</td>
{{< /datatable-head >}}

{{< datatable file="pets.yaml" >}}
<td>{{ .category }}</td>
<td>{{ .name }}</td>
{{< /datatable >}}


{{< datatable file="pets.yaml" headers="Category,Name,Tags" >}}
<td>{{ .category }}</td>
<td>{{ .name }}</td>
{{< /datatable >}}

