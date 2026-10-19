---
---

{{< datatable-data >}}
42	Answer	84
3.14	Pi	6.28
{{< /datatable-data >}}

{{< datatable headers="Number,Meaning,Double" type="tsv" >}}
<td>{{ index . 0 }}</td>
<td><em>{{ index . 1 }}</em></td>
<td>x 2 = {{ index . 2 }}</td>
{{< /datatable >}}
