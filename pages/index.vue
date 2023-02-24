<template>
  <div class="ma-5">
    <div class="d-flex flex-row">
      <div class="flex-2">
        <h1>Base d'étudiants</h1>
        <students-table :students="students" @check="(id) => checkStudentDegree(id)"></students-table>
      </div>
      <div class="flex-1 ml-2">
        <h2>Formulaire création d'étudiant</h2>
        <v-text-field label="Nom" v-model="lastName"></v-text-field>
        <v-text-field label="Prénom" v-model="firstName"></v-text-field>
        <v-text-field label="Adresse" v-model="address"></v-text-field>
        <v-text-field label="Email" v-model="email"></v-text-field>
        <v-text-field label="Téléphone" v-model="phone"></v-text-field>
        <v-text-field label="Nom du réferent" v-model="referent"></v-text-field>
        <v-btn @click="createStudent">Créer un student</v-btn>
      </div>
    </div>
  </div>
</template>

<script setup>
import { useContractStore } from "../stores/contractStore";

const { init, submitStudent, students, getStudents } = useContractStore();

const config = useRuntimeConfig()

onMounted(async () => {
  await init(config.public.TOKEN_CONTRACT_ADDRESS, config.public.DIPLOMA_CONTRACT_ADDRESS);
  await getStudents();
})

const lastName = ref('')
const firstName = ref('')
const address = ref('')
const email = ref('')
const phone = ref('')
const referent = ref('')

const createStudent = async () => {
  await submitStudent(
      lastName.value, 
      firstName.value, 
      address.value, 
      email.value, 
      phone.value, 
      referent.value
  )
}
</script>

<style>
.flex-1 {
  flex: 1;
}
.flex-2 {
  flex: 2;
}
</style>