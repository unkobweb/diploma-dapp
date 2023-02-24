<template>
  <v-table>
    <thead>
      <tr>
        <th class="text-left">
          Prénom
        </th>
        <th class="text-left">
          Nom de famille
        </th>
        <th class="text-left">
          Date de naissance
        </th>
        <th class="text-left">
          Adresse
        </th>
        <th class="text-left">
          Email
        </th>
        <th class="text-left">
          Téléphone
        </th>
        <th class="text-left">
          Company
        </th>
        <th class="text-left">
          Nom du référent
        </th>
        <th class="text-left">
          Début de la période en entreprise
        </th>
        <th class="text-left">
          Fin de la période en entreprise
        </th>
      </tr>
    </thead>
    <tbody>
      <tr
        v-for="student in students"
        :key="student.id"
      >
        <td>{{ student.firstName }}</td>
        <td>{{ student.lastName }}</td>
        <td>{{ new Date(+student.birthDate).toLocaleDateString() }}</td>
        <td>{{ student.studentAddress }}</td>
        <td>{{ student.email }}</td>
        <td>{{ student.telephone }}</td>
        <td>{{ student.company }}</td>
        <td>{{ student.referentName }}</td>
        <td>{{ new Date(+student.startDate).toLocaleDateString() }}</td>
        <td>{{ new Date(+student.endDate).toLocaleDateString() }}</td>
      </tr>
    </tbody>
  </v-table>
</template>

<script setup>
// get students props from parent
const { students } = defineProps(['students'])
</script>