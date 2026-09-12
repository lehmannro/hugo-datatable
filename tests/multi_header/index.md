---
---
{{< datatable-head >}}
<td colspan=2>Category-name</td>
<td>Tags</td>
{{< /datatable-head >}}

{{< datatable file="pets.yaml" headers="Category,Name,Tags" >}}
<td>{{ .category }}</td>
<td>{{ .name }}</td>
<td>{{ delimit .tags " / " }}</td>
{{< /datatable >}}

