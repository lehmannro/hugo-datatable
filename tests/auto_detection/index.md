---
---

{{< datatable file="local.csv" headers="Category,Name" >}}
<td>{{ index . 0 }}</td>
<td>{{ index . 1 | upper }}</td>
{{< /datatable >}}


{{< datatable-data >}}
Dog,Max
Cat,Oscar
{{< /datatable-data >}}

{{< datatable headers="Name,Category" >}}
<td>{{ index . 1 | upper }}</td>
<td>{{ index . 0 }}</td>
{{< /datatable >}}
