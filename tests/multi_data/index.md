---
---
{{< datatable-data >}}
- name: Ginger
  category: Hamster
  tags: []
{{< /datatable-data >}}

{{< datatable file="pets.yaml" headers="A,B" >}}
<td>{{ .name }}</td>
{{< /datatable >}}

