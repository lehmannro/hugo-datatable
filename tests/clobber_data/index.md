---
---
{{< datatable-data >}}
- name: Ginger
  category: Hamster
  tags: []
{{< /datatable-data >}}

{{< datatable headers="Pet" >}}
<td>{{ .name }}</td>
{{< /datatable >}}

{{< datatable file="pets.yaml" headers="Pet" >}}
<td>{{ .name }}</td>
{{< /datatable >}}

