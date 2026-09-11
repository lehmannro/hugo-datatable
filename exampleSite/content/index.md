Example site for `hugo-datatable`.

{{< datatable file="pets.yaml" headers="Category,Name,Tags" >}}
<td><em>{{ .category }}</em></td>
<td>{{ .name | upper }}</td>
<td>{{ delimit .tags " / " }}</td>
{{< /datatable >}}

