---
---

{{< datatable file="local.yaml" headers="Everyone but Cats" >}}
{{ if ne .category "Cat" }}
  <td>{{ .name }}</td>
{{ end }}
{{< /datatable >}}

{{< datatable file="local.yaml" headers="Everyone but Cats" >}}
{{ if ne .category "Cat" }}
  <td>{{ .name }}</td>
{{ else }}
  <!-- here be cats -->
{{ end }}
{{< /datatable >}}
