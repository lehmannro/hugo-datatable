---
---

{{< datatable file="local.txt" type="csv" headers="Category,Name" >}}
<td>{{ index . 0 }}</td>
<td>{{ index . 1 | upper }}</td>
{{< /datatable >}}
