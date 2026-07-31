<div class="container py-5 text-center">

<h1>
Thank you for your order!
</h1>


<p>
Your payment was successful.
</p>


<p>
Your order number is:
<strong>
#<%= @order.id %>
</strong>
</p>


<%= link_to "View My Orders",
            orders_path,
            class: "btn btn-success" %>


</div>