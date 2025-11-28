<%@ page contentType="text/html;charset=UTF-8" %>
<script src="${pageContext.request.contextPath}/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script>
// Small utility: toggle sidebar on small screens
(function(){
  const sidebar = document.querySelector('.glass-sidebar');
  if(!sidebar) return;
  document.addEventListener('click', e=>{
    if(e.target.matches('[data-toggle="admin-sidebar"]')){
      sidebar.classList.toggle('show');
    }
  });
})();
</script>
</main>
</div>
</body>
</html>
