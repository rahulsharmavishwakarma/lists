const { createApp, ref, computed, onMounted, watch } = Vue;

createApp({
    setup() {
        const API_BASE_URL = '/api';

        const todos = ref([]);
        const tags = ref([]);
        const currentFilter = ref('all');
        const currentPriority = ref('all');
        const currentTag = ref(null);
        const searchQuery = ref('');
        const draggingTodo = ref(null);
        const showTodoModal = ref(false);
        const showTagModal = ref(false);
        const editingTodo = ref(null);

        const todoForm = ref({
            id: null,
            title: '',
            description: '',
            priority: 'medium',
            due_date: null,
            tag_ids: [],
            subtasks: []
        });

        const tagForm = ref({
            name: '',
            color: '#6366f1'
        });

        const filteredTodos = computed(() => {
            let result = todos.value;
            
            if (currentFilter.value === 'active') {
                result = result.filter(t => !t.completed);
            } else if (currentFilter.value === 'completed') {
                result = result.filter(t => t.completed);
            }
            
            if (currentPriority.value !== 'all') {
                result = result.filter(t => t.priority === currentPriority.value);
            }
            
            if (currentTag.value) {
                result = result.filter(t => t.tags.some(tag => tag.id === currentTag.value.id));
            }
            
            if (searchQuery.value) {
                const query = searchQuery.value.toLowerCase();
                result = result.filter(t => 
                    t.title.toLowerCase().includes(query) ||
                    (t.description && t.description.toLowerCase().includes(query))
                );
            }
            
            return result.sort((a, b) => a.position - b.position);
        });

        const activeTodosCount = computed(() => todos.value.filter(t => !t.completed).length);
        const completedTodosCount = computed(() => todos.value.filter(t => t.completed).length);

        async function fetchTodos() {
            try {
                const response = await fetch(`${API_BASE_URL}/todos/`);
                todos.value = await response.json();
            } catch (error) {
                console.error('Error fetching todos:', error);
            }
        }

        async function fetchTags() {
            try {
                const response = await fetch(`${API_BASE_URL}/tags/`);
                tags.value = await response.json();
            } catch (error) {
                console.error('Error fetching tags:', error);
            }
        }

        function priorityLabel(priority) {
            return priority.charAt(0).toUpperCase() + priority.slice(1);
        }

        function formatDate(dateString) {
            if (!dateString) return '';
            const date = new Date(dateString);
            return date.toLocaleDateString('en-US', { 
                month: 'short', 
                day: 'numeric',
                year: 'numeric',
                hour: '2-digit',
                minute: '2-digit'
            });
        }

        function isOverdue(dateString) {
            if (!dateString) return false;
            return new Date(dateString) < new Date();
        }

        function todoCountByTag(tagId) {
            return todos.value.filter(t => t.tags.some(tag => tag.id === tagId)).length;
        }

        function openModal(todo = null) {
            if (todo) {
                editingTodo.value = todo;
                todoForm.value = {
                    id: todo.id,
                    title: todo.title,
                    description: todo.description || '',
                    priority: todo.priority,
                    due_date: todo.due_date || null,
                    tag_ids: todo.tags ? todo.tags.map(t => t.id) : [],
                    subtasks: todo.subtasks ? todo.subtasks.map(s => ({ ...s })) : []
                };
            } else {
                editingTodo.value = null;
                todoForm.value = {
                    id: null,
                    title: '',
                    description: '',
                    priority: 'medium',
                    due_date: null,
                    tag_ids: [],
                    subtasks: []
                };
            }
            showTodoModal.value = true;
        }

        function closeModal() {
            showTodoModal.value = false;
            editingTodo.value = null;
            todoForm.value = {
                id: null,
                title: '',
                description: '',
                priority: 'medium',
                due_date: null,
                tag_ids: [],
                subtasks: []
            };
        }

        async function saveTodo() {
            try {
                const todoData = {
                    title: todoForm.value.title,
                    description: todoForm.value.description || null,
                    priority: todoForm.value.priority,
                    due_date: todoForm.value.due_date || null,
                    tag_ids: todoForm.value.tag_ids,
                    subtasks: todoForm.value.subtasks
                };

                if (todoForm.value.id) {
                    await fetch(`${API_BASE_URL}/todos/${todoForm.value.id}`, {
                        method: 'PUT',
                        headers: { 'Content-Type': 'application/json' },
                        body: JSON.stringify(todoData)
                    });
                } else {
                    await fetch(`${API_BASE_URL}/todos/`, {
                        method: 'POST',
                        headers: { 'Content-Type': 'application/json' },
                        body: JSON.stringify(todoData)
                    });
                }
                
                await fetchTodos();
                closeModal();
            } catch (error) {
                console.error('Error saving todo:', error);
                alert('Failed to save task. Please try again.');
            }
        }

        async function toggleTodo(todoId) {
            try {
                await fetch(`${API_BASE_URL}/todos/${todoId}/toggle`, { method: 'PATCH' });
                await fetchTodos();
            } catch (error) {
                console.error('Error toggling todo:', error);
            }
        }

        async function deleteTodo(todoId) {
            if (!confirm('Are you sure you want to delete this task?')) return;
            
            try {
                await fetch(`${API_BASE_URL}/todos/${todoId}`, { method: 'DELETE' });
                await fetchTodos();
            } catch (error) {
                console.error('Error deleting todo:', error);
                alert('Failed to delete task. Please try again.');
            }
        }

        function addSubtask() {
            todoForm.value.subtasks.push({
                title: '',
                completed: false,
                position: todoForm.value.subtasks.length
            });
        }

        function removeSubtask(index) {
            todoForm.value.subtasks.splice(index, 1);
        }

        async function toggleSubtask(todoId, subtaskId) {
            try {
                await fetch(`${API_BASE_URL}/todos/${todoId}/subtasks/${subtaskId}/toggle`, { method: 'PATCH' });
                await fetchTodos();
            } catch (error) {
                console.error('Error toggling subtask:', error);
            }
        }

        function openTagModal() {
            tagForm.value = {
                name: '',
                color: '#6366f1'
            };
            showTagModal.value = true;
        }

        function closeTagModal() {
            showTagModal.value = false;
            tagForm.value = {
                name: '',
                color: '#6366f1'
            };
        }

        async function saveTag() {
            try {
                await fetch(`${API_BASE_URL}/tags/`, {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify(tagForm.value)
                });
                await fetchTags();
                closeTagModal();
            } catch (error) {
                console.error('Error creating tag:', error);
                alert('Failed to create tag. Please try again.');
            }
        }

        async function deleteTag(tagId) {
            if (!confirm('Are you sure you want to delete this tag?')) return;
            
            try {
                await fetch(`${API_BASE_URL}/tags/${tagId}`, { method: 'DELETE' });
                await fetchTags();
                if (currentTag.value?.id === tagId) {
                    currentTag.value = null;
                }
                await fetchTodos();
            } catch (error) {
                console.error('Error deleting tag:', error);
                alert('Failed to delete tag. Please try again.');
            }
        }

        function handleDragStart(todo) {
            draggingTodo.value = todo;
        }

        function handleDragEnd() {
            draggingTodo.value = null;
        }

        function handleDragOver(event) {
            event.preventDefault();
        }

        async function handleDrop(event, targetTodo) {
            event.preventDefault();
            if (!draggingTodo.value || draggingTodo.value.id === targetTodo.id) return;
            
            const newOrder = filteredTodos.value.map(t => t.id);
            const draggedIndex = newOrder.indexOf(draggingTodo.value.id);
            const targetIndex = newOrder.indexOf(targetTodo.id);
            
            newOrder.splice(draggedIndex, 1);
            newOrder.splice(targetIndex, 0, draggingTodo.value.id);
            
            try {
                await fetch(`${API_BASE_URL}/todos/reorder`, {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify(newOrder)
                });
                await fetchTodos();
            } catch (error) {
                console.error('Error reordering todos:', error);
            }
        }

        function handleSearch() {
            // Debounced search handled by Vue's reactivity
        }

        watch(currentFilter, async () => {
            await fetchTodos();
        });

        watch(currentPriority, async () => {
            await fetchTodos();
        });

        watch(currentTag, async () => {
            await fetchTodos();
        });

        onMounted(async () => {
            await fetchTags();
            await fetchTodos();
        });

        return {
            todos,
            tags,
            currentFilter,
            currentPriority,
            currentTag,
            searchQuery,
            draggingTodo,
            showTodoModal,
            showTagModal,
            editingTodo,
            todoForm,
            tagForm,
            filteredTodos,
            activeTodosCount,
            completedTodosCount,
            priorityLabel,
            formatDate,
            isOverdue,
            todoCountByTag,
            openModal,
            closeModal,
            saveTodo,
            toggleTodo,
            deleteTodo,
            toggleSubtask,
            addSubtask,
            removeSubtask,
            openTagModal,
            closeTagModal,
            saveTag,
            deleteTag,
            handleDragStart,
            handleDragEnd,
            handleDragOver,
            handleDrop,
            handleSearch
        };
    }
}).mount('#app');
