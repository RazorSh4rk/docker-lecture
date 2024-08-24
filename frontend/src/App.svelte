<script lang="ts">
  import { onMount } from "svelte";

  let data: { message: string } = {
    message: "",
  };
  let inputVal = "";

  const putValue = () => {
    fetch(`http://localhost:3000/set?v=${inputVal}`)
      .then(console.log)
      .catch(console.log);
  };

  const getValue = () => {
    fetch(`http://localhost:3000/get`)
      .then((res) => res.json())
      .then((d) => (data = d));
  };

  onMount(() => {
    getValue()
  });
</script>

<main>
  <div class="wrapper">
    <div class="term">{data.message}</div>
    <div>
      <button on:click={getValue}> 🔄 </button>
    </div>
  </div>
  <div>
    <input type="text" bind:value={inputVal} placeholder="new value" />
    <button on:click={putValue}>upload</button>
  </div>
</main>

<style>
  .wrapper {
    display: flex;
    justify-content: center;
  }
  .term {
    border: 1px solid white;
    padding: 10px;
    width: 100%;
  }
  input {
    padding: 10px;
  }
</style>
