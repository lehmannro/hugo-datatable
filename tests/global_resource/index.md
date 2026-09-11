---
---
{{< datatable file="pets.yaml" headers="Category,Name,Tags" >}}
<td>{{ .category }}</td>
<td>{{ .name }}</td>
<td>{{ delimit .tags " / " }}</td>
{{< /datatable >}}

