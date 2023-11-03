<script lang="ts">
import { defineComponent } from 'vue'
import api from '../http.ts'

interface Post {
  title: string,
  body: string
}

export default defineComponent({
  data() {
    return {
      posts: [] as Post[],
      title: String,
      body: String
    }
  },

  methods: {
    async loadPosts() {
      const response = await api.get("/posts")
      this.posts = response.data as Post[]
    },

    clearForm() {
      this.title = ""
      this.body = ""
    },

    async createPost() {
      await api.post("/posts", { title: this.title, body: this.body })
      this.clearForm()
      this.loadPosts()
    }
  },

  async mounted() {
    this.clearForm()
    await this.loadPosts()
  }
})
</script>

<template>
  New Post:
  <div class="form-post">
    <div>
      <label for="input-title">Title:</label>
      <input type="text" id="input-title" v-model="title">
    </div>
    <div>
      <label for="input-body">Body:</label>
      <textarea id="input-body" v-model="body" />
    </div>
    <button @click="createPost">Create Post</button>
  </div>
  <h1>Posts</h1>

  <div v-for="post in posts">
    <div class="item-post">
      <h3>{{ post.title }}</h3>
      <div>{{ post.body }}</div>
    </div>
  </div>
</template>

<style type="text/css">
.form-post label {
  display: block;
}
.item-post {
  background-color: #303030;
  border-radius: 15px;
  padding: 15px;
  margin-bottom: 20px;
}
</style>