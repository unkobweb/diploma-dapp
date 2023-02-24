import erc20 from '../assets/erc20.json'
import diplomaABI from '../assets/diploma.json'
import Web3 from 'web3'

export const useContractStore = defineStore('contractStore', () => {
  const students = ref([]);
  const tokenContractInstance = ref(null);
  const diplomaContractInstance = ref(null);
  const web3 = ref(null);

  async function init(tokenContractAddress, diplomaContractAddress) {
    if (typeof window !== 'undefined' && typeof window.ethereum !== 'undefined') {
      web3.value = new Web3(window.ethereum);
      try {
        await window.ethereum.enable();
        const tokenContractABI = erc20;
        tokenContractInstance.value = new web3.value.eth.Contract(tokenContractABI, tokenContractAddress);
        const diplomaContractABI = diplomaABI;
        diplomaContractInstance.value = new web3.value.eth.Contract(diplomaContractABI, diplomaContractAddress);
      } catch (error) {
        console.log(error);
        console.error('User denied account access');
      }
    } else {
      const provider = new Web3.providers.HttpProvider('http://localhost:8545');
      web3.value = new Web3(provider);
    }
  }

  async function getStudents() {
    let studentId = students.value.length;
    let student = null;
    do {
      try {
        student = null;
        const tx = await diplomaContractInstance.value.methods.students(studentId).call();
        students.value.push(tx);
        student = tx;
        studentId++;
      } catch (error) {
        console.log("Pas de student id : " + studentId);
      }
    } while (student);
  }

  const submitStudent = async (lastName, firstName, address, email, phone, referent) => {
    const accounts = await web3.value.eth.getAccounts()
    const account = accounts[0]
    console.log([
      lastName, 
      firstName, 
      new Date().getTime(), 
      address, 
      email, 
      phone, 
      accounts[0], 
      referent, 
      new Date().getTime(), 
      new Date().getTime()
    ])
    const tx = await diplomaContractInstance.value.methods.createStudent([
      lastName, 
      firstName, 
      new Date().getTime(), 
      address, 
      email, 
      phone, 
      accounts[0], 
      referent, 
      new Date().getTime(), 
      new Date().getTime()
    ]).send({ from: account })
    await getStudents()
  }

  return { students, tokenContractInstance, diplomaContractInstance, web3, init, getStudents, submitStudent}
});