---
my_table:
- name: Rex
  category: Dog
---
{{< datatable-data >}}
- name: Ginger
  category: Hamster
  tags: []
{{< /datatable-data >}}

{{< datatable file="pets.yaml" data="dat" param="my_table" headers="A,B" >}}
<td>{{ .name }}</td>
{{< /datatable >}}

