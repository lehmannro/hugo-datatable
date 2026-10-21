---
---

{{< datatable file="pets.yaml" headers="Stylish pets" tr=false >}}
<tr class="{{ .category | lower }}">
  <td>{{ .name }}</td>
</tr>
{{< /datatable >}}
