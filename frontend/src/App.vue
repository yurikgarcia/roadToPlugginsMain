<script lang="ts" setup>
import { ref } from "vue";
import HelloWorld from "./components/HelloWorld.vue";

const isLeftEyeClosed = ref(false);
const toggleLeftEye = () => {
  isLeftEyeClosed.value = !isLeftEyeClosed.value;
};

const isRightEyeClosed = ref(false);
const toggleRightEye = () => {
  isRightEyeClosed.value = !isRightEyeClosed.value;
};
</script>

<template>
 <div class="container">
    <div class="face">
      <div
        class="eye"
        :class="{ 'eye-closed': isLeftEyeClosed }"
        @click="toggleLeftEye"
      ></div>
      <div
        class="eye"
        :class="{ 'eye-closed': isRightEyeClosed }"
        @click="toggleRightEye"
      ></div>
      <div class="mouth"></div>

    </div>
    <HelloWorld />
  </div>
</template>

<style scoped>
.container {
  width: 100%;
  height: 100%;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  gap: 50px;
  background-color: #000;
  color: #ffffff;
}

.face {
  width: 200px;
  height: 200px;
  border-radius: 50%;
  background-color: #5d5d5d;
  position: relative; /* Ensure z-index works */
  display: flex;
  justify-content: space-around;
  align-items: center;
  z-index: 2; /* Make sure this is higher */
}

.eye {
  cursor: pointer;
  width: 30px;
  height: 30px;
  background-color: #fefefe;
  border-radius: 50%;
  position: relative;
  top: -20px;
}

.eye-closed {
  height: 10px;
  transition: height 0.3s ease-in-out;
}

.mouth {
  width: 100px;
  height: 20px;
  background-color: #fefefe;
  position: absolute;
  bottom: 40px;
  left: 50%;
  transform: translateX(-50%);
  border-radius: 0 0 50px 50px;
}
</style>

