---
---
{{< datatable-head >}}
<th colspan=2>Category-name</th>
<th>Tags</th>
{{< /datatable-head >}}

{{< datatable file="pets.yaml" >}}
<td>{{ .category }}</td>
<td>{{ .name }}</td>
<td>{{ delimit .tags " / " }}</td>
{{< /datatable >}}

