const myVehicle = {
    brand: 'Ford',
    model: 'Mustang',
    color: 'red'
  }
  
  const updateMyVehicle = {
    type: 'car',
    year: 2021, 
    color: 'yellow'
  }
  
  const myUpdatedVehicle = {...myVehicle, ...updateMyVehicle}
  
  //Check the result object in the console:
  console.log(myUpdatedVehicle);
  
  const numbers = [1, 2, 3, 4, 5, 6];
  
  const [one, two, ...rest] = numbers;
  
  console.log(one);
  console.log(two);
  console.log(three);