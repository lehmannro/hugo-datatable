---
---
{{< datatable-head >}}{{< /datatable-head >}}

{{< datatable file="pets.yaml" >}}
<td>{{ .name }}</td>
{{< /datatable >}}

We know this worked if TR has an empty TD, instead of the usual TH.
