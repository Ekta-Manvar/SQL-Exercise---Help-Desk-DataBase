<!DOCTYPE html>
<html>

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Welcome file</title>
  <link rel="stylesheet" href="https://stackedit.io/style.css" />
</head>

<body class="stackedit">
  <div class="stackedit__html"><h4 id="there-are-three-issues-that-include-the-words-index-and-oracle.-find-the-call_date-for-each-of-them">1. There are three issues that include the words “index” and “Oracle”. Find the call_date for each of them</h4>
<pre class=" language-sql"><code class="prism  language-sql"><span class="token keyword">SELECT</span> 
    call_date<span class="token punctuation">,</span> call_ref
<span class="token keyword">FROM</span>
    Issue
<span class="token keyword">WHERE</span>
    detail <span class="token operator">LIKE</span> <span class="token string">'%index%'</span>
        <span class="token operator">AND</span> detail <span class="token operator">LIKE</span> <span class="token string">'%oracle%'</span><span class="token punctuation">;</span>
        
</code></pre>
<h4 id="samantha-hall-made-three-calls-on-2017-08-14.-show-the-date-and-time-for-each">2. Samantha Hall made three calls on 2017-08-14. Show the date and time for each</h4>
<pre class=" language-sql"><code class="prism  language-sql"><span class="token keyword">SELECT</span> 
     call_date<span class="token punctuation">,</span> first_name<span class="token punctuation">,</span> last_name
<span class="token keyword">FROM</span>
    Issue i
        <span class="token keyword">JOIN</span>
    Caller <span class="token number">c</span> <span class="token keyword">ON</span> i<span class="token punctuation">.</span>caller_id <span class="token operator">=</span> <span class="token number">c</span><span class="token punctuation">.</span>caller_id
<span class="token keyword">WHERE</span>
    first_name <span class="token operator">=</span> <span class="token string">'Samantha'</span>
        <span class="token operator">AND</span> last_name <span class="token operator">=</span> <span class="token string">'Hall'</span>
        <span class="token operator">AND</span> <span class="token keyword">DATE</span><span class="token punctuation">(</span>call_date<span class="token punctuation">)</span> <span class="token operator">=</span> <span class="token string">'2017-08-14'</span><span class="token punctuation">;</span>
</code></pre>
<h4 id="there-are-500-calls-in-the-system-roughly.-write-a-query-that-shows-the-number-that-have-each-status">3.There are 500 calls in the system (roughly). Write a query that shows the number that have each status</h4>
<pre class=" language-sql"><code class="prism  language-sql"><span class="token keyword">SELECT</span> 
    <span class="token keyword">status</span><span class="token punctuation">,</span> <span class="token function">COUNT</span><span class="token punctuation">(</span>caller_id<span class="token punctuation">)</span> <span class="token keyword">AS</span> Volume
<span class="token keyword">FROM</span>
    Issue 
<span class="token keyword">GROUP</span> <span class="token keyword">BY</span> <span class="token keyword">status</span><span class="token punctuation">;</span>
 
</code></pre>
<h4 id="calls-are-not-normally-assigned-to-a-manager-but-it-does-happen.-how-many-calls-have-been-assigned-to-staff-who-are-at-manager-level">4. Calls are not normally assigned to a manager but it does happen. How many calls have been assigned to staff who are at Manager Level?</h4>
<pre class=" language-sql"><code class="prism  language-sql"> <span class="token keyword">SELECT</span> 
    <span class="token function">COUNT</span><span class="token punctuation">(</span>i<span class="token punctuation">.</span>caller_id<span class="token punctuation">)</span> <span class="token keyword">AS</span> mlcc
<span class="token keyword">FROM</span>
    Level l
        <span class="token keyword">JOIN</span>
    Staff s <span class="token keyword">ON</span> l<span class="token punctuation">.</span>level_code <span class="token operator">=</span> s<span class="token punctuation">.</span>level_code
        <span class="token keyword">JOIN</span>
    Issue i <span class="token keyword">ON</span> s<span class="token punctuation">.</span>staff_code <span class="token operator">=</span> i<span class="token punctuation">.</span>assigned_to
<span class="token keyword">WHERE</span>
    l<span class="token punctuation">.</span>manager <span class="token operator">=</span> <span class="token string">'Y'</span>
<span class="token keyword">GROUP</span> <span class="token keyword">BY</span> l<span class="token punctuation">.</span>manager<span class="token punctuation">;</span>
</code></pre>
<h4 id="show-the-manager-for-each-shift.-your-output-should-include-the-shift-date-and-type-also-the-first-and-last-name-of-the-manager.">5.Show the manager for each shift. Your output should include the shift date and type; also the first and last name of the manager.</h4>
<pre class=" language-sql"><code class="prism  language-sql"> <span class="token keyword">SELECT</span> 
    sf<span class="token punctuation">.</span>shift_date<span class="token punctuation">,</span>
    sf<span class="token punctuation">.</span>shift_type<span class="token punctuation">,</span>
    st<span class="token punctuation">.</span>first_name<span class="token punctuation">,</span>
    st<span class="token punctuation">.</span>last_name
<span class="token keyword">FROM</span>
    Shift sf
        <span class="token keyword">JOIN</span>
    Staff st <span class="token keyword">ON</span> sf<span class="token punctuation">.</span>manager <span class="token operator">=</span> st<span class="token punctuation">.</span>staff_code
<span class="token keyword">ORDER</span> <span class="token keyword">BY</span> sf<span class="token punctuation">.</span>shift_date<span class="token punctuation">;</span>
</code></pre>
<h4 id="list-the-company-name-and-the-number-of-calls-for-those-companies-with-more-than-18-calls.">6.List the Company name and the number of calls for those companies with more than 18 calls.</h4>
<pre class=" language-sql"><code class="prism  language-sql"><span class="token keyword">SELECT</span> 
    <span class="token number">c</span><span class="token punctuation">.</span>company_name<span class="token punctuation">,</span> <span class="token function">COUNT</span><span class="token punctuation">(</span>i<span class="token punctuation">.</span>caller_id<span class="token punctuation">)</span> <span class="token keyword">AS</span> <span class="token number">cc</span>
<span class="token keyword">FROM</span>
    Customer <span class="token number">c</span>
        <span class="token keyword">JOIN</span>
    Caller cl <span class="token keyword">ON</span> <span class="token number">c</span><span class="token punctuation">.</span>company_ref <span class="token operator">=</span> cl<span class="token punctuation">.</span>company_ref
        <span class="token keyword">JOIN</span>
    Issue i <span class="token keyword">ON</span> cl<span class="token punctuation">.</span>caller_id <span class="token operator">=</span> i<span class="token punctuation">.</span>caller_id
<span class="token keyword">GROUP</span> <span class="token keyword">BY</span> <span class="token number">c</span><span class="token punctuation">.</span>company_name
<span class="token keyword">HAVING</span> <span class="token function">COUNT</span><span class="token punctuation">(</span>i<span class="token punctuation">.</span>caller_id<span class="token punctuation">)</span> <span class="token operator">&gt;</span> <span class="token number">18</span>
</code></pre>
<h4 id="find-the-callers-who-have-never-made-a-call.-show-first-name-and-last-name">7.Find the callers who have never made a call. Show first name and last name</h4>
<pre class=" language-sql"><code class="prism  language-sql"><span class="token keyword">SELECT</span> 
    <span class="token number">c</span><span class="token punctuation">.</span>first_name<span class="token punctuation">,</span> <span class="token number">c</span><span class="token punctuation">.</span>last_name
<span class="token keyword">FROM</span>
    Caller <span class="token number">c</span>
        <span class="token keyword">LEFT</span> <span class="token keyword">JOIN</span>
    Issue i <span class="token keyword">ON</span> <span class="token number">c</span><span class="token punctuation">.</span>caller_id <span class="token operator">=</span> i<span class="token punctuation">.</span>caller_id
<span class="token keyword">WHERE</span>
    i<span class="token punctuation">.</span>caller_id <span class="token operator">IS</span> <span class="token boolean">NULL</span><span class="token punctuation">;</span>
</code></pre>
<h4 id="for-each-shift-show-the-number-of-staff-assigned.-beware-that-some-roles-may-be-null-and-that-the-same-person-might-have-been-assigned-to-multiple-roles-the-roles-are-manager-operator-engineer1-engineer2.">8.For each shift show the number of staff assigned. Beware that some roles may be NULL and that the same person might have been assigned to multiple roles (The roles are ‘Manager’, ‘Operator’, ‘Engineer1’, ‘Engineer2’).</h4>
<pre class=" language-sql"><code class="prism  language-sql"><span class="token keyword">SELECT</span> 
    <span class="token number">f</span><span class="token punctuation">.</span>shift_date<span class="token punctuation">,</span> <span class="token number">f</span><span class="token punctuation">.</span>shift_type<span class="token punctuation">,</span> <span class="token function">COUNT</span><span class="token punctuation">(</span><span class="token keyword">DISTINCT</span> role<span class="token punctuation">)</span> <span class="token keyword">AS</span> cw
<span class="token keyword">FROM</span>
    <span class="token punctuation">(</span><span class="token keyword">SELECT</span> 
        shift_date<span class="token punctuation">,</span> shift_type<span class="token punctuation">,</span> manager <span class="token keyword">AS</span> role
    <span class="token keyword">FROM</span>
        Shift <span class="token keyword">UNION</span> <span class="token keyword">SELECT</span> 
        shift_date<span class="token punctuation">,</span> shift_type<span class="token punctuation">,</span> operator <span class="token keyword">AS</span> role
    <span class="token keyword">FROM</span>
        Shift <span class="token keyword">UNION</span> <span class="token keyword">SELECT</span> 
        shift_date<span class="token punctuation">,</span> shift_type<span class="token punctuation">,</span> engineer1 <span class="token keyword">AS</span> role
    <span class="token keyword">FROM</span>
        Shift <span class="token keyword">UNION</span> <span class="token keyword">SELECT</span> 
        shift_date<span class="token punctuation">,</span> shift_type<span class="token punctuation">,</span> engineer2 <span class="token keyword">AS</span> role
    <span class="token keyword">FROM</span>
        Shift<span class="token punctuation">)</span> <span class="token keyword">AS</span> <span class="token number">f</span>
<span class="token keyword">GROUP</span> <span class="token keyword">BY</span> <span class="token number">f</span><span class="token punctuation">.</span>shift_date <span class="token punctuation">,</span> <span class="token number">f</span><span class="token punctuation">.</span>shift_type<span class="token punctuation">;</span>
</code></pre>
<h4 id="caller-harry-claims-that-the-operator-who-took-his-most-recent-call-was-abusive-and-insulting.-find-out-who-took-the-call-full-name-and-when.">9.Caller ‘Harry’ claims that the operator who took his most recent call was abusive and insulting. Find out who took the call (full name) and when.</h4>
<h5 id="st-way">1st way</h5>
<pre class=" language-sql"><code class="prism  language-sql"><span class="token keyword">SELECT</span> 
    i<span class="token punctuation">.</span>call_date<span class="token punctuation">,</span> s<span class="token punctuation">.</span>first_name<span class="token punctuation">,</span> s<span class="token punctuation">.</span>last_name
<span class="token keyword">FROM</span>
    Issue i
        <span class="token keyword">JOIN</span>
    Caller <span class="token keyword">AS</span> <span class="token number">c</span> <span class="token keyword">ON</span> i<span class="token punctuation">.</span>caller_id <span class="token operator">=</span> <span class="token number">c</span><span class="token punctuation">.</span>caller_id
        <span class="token keyword">JOIN</span>
    Staff s <span class="token keyword">ON</span> i<span class="token punctuation">.</span>taken_by <span class="token operator">=</span> s<span class="token punctuation">.</span>staff_code
<span class="token keyword">WHERE</span>
    <span class="token number">c</span><span class="token punctuation">.</span>first_name <span class="token operator">=</span> <span class="token string">'Harry'</span>
<span class="token keyword">ORDER</span> <span class="token keyword">BY</span> i<span class="token punctuation">.</span>call_date <span class="token keyword">DESC</span>
<span class="token keyword">LIMIT</span> <span class="token number">1</span><span class="token punctuation">;</span>
</code></pre>
<h5 id="nd-way">2nd way</h5>
<pre class=" language-sql"><code class="prism  language-sql"><span class="token keyword">SELECT</span> 
    i<span class="token punctuation">.</span>call_date<span class="token punctuation">,</span> s<span class="token punctuation">.</span>first_name<span class="token punctuation">,</span> s<span class="token punctuation">.</span>last_name
<span class="token keyword">FROM</span>
    Staff s
        <span class="token keyword">JOIN</span>
    <span class="token punctuation">(</span><span class="token keyword">SELECT</span> 
        i<span class="token punctuation">.</span>call_date<span class="token punctuation">,</span> i<span class="token punctuation">.</span>taken_by
    <span class="token keyword">FROM</span>
        Issue i
    <span class="token keyword">WHERE</span>
        i<span class="token punctuation">.</span>caller_id <span class="token operator">IN</span> <span class="token punctuation">(</span><span class="token keyword">SELECT</span> 
                caller_id
            <span class="token keyword">FROM</span>
                Caller
            <span class="token keyword">WHERE</span>
                first_name <span class="token operator">=</span> <span class="token string">'Harry'</span><span class="token punctuation">)</span><span class="token punctuation">)</span> <span class="token keyword">AS</span> i <span class="token keyword">ON</span> i<span class="token punctuation">.</span>taken_by <span class="token operator">=</span> s<span class="token punctuation">.</span>staff_code
<span class="token keyword">ORDER</span> <span class="token keyword">BY</span> i<span class="token punctuation">.</span>call_date <span class="token keyword">DESC</span>
<span class="token keyword">LIMIT</span> <span class="token number">1</span><span class="token punctuation">;</span>
</code></pre>
<h4 id="annoying-customers.-customers-who-call-in-the-last-five-minutes-of-a-shift-are-annoying.-find-the-most-active-customer-who-has-never-been-annoying.">10. Annoying customers. Customers who call in the last five minutes of a shift are annoying. Find the most active customer who has never been annoying.</h4>
<pre class=" language-sql"><code class="prism  language-sql"><span class="token keyword">SELECT</span> 
    <span class="token number">c</span><span class="token punctuation">.</span>company_name<span class="token punctuation">,</span> <span class="token function">COUNT</span><span class="token punctuation">(</span><span class="token operator">*</span><span class="token punctuation">)</span> <span class="token keyword">AS</span> abna
<span class="token keyword">FROM</span>
    Customer <span class="token number">c</span>
        <span class="token keyword">JOIN</span>
    Caller cl <span class="token keyword">ON</span> <span class="token number">c</span><span class="token punctuation">.</span>company_ref <span class="token operator">=</span> cl<span class="token punctuation">.</span>company_ref
        <span class="token keyword">JOIN</span>
    Issue i <span class="token keyword">ON</span> cl<span class="token punctuation">.</span>caller_id <span class="token operator">=</span> i<span class="token punctuation">.</span>caller_id
<span class="token keyword">WHERE</span>
    <span class="token number">c</span><span class="token punctuation">.</span>company_name <span class="token operator">NOT</span> <span class="token operator">IN</span> <span class="token punctuation">(</span><span class="token keyword">SELECT</span> 
            <span class="token number">c</span><span class="token punctuation">.</span>company_name
        <span class="token keyword">FROM</span>
            Customer <span class="token number">c</span>
                <span class="token keyword">JOIN</span>
            Caller cl <span class="token keyword">ON</span> <span class="token number">c</span><span class="token punctuation">.</span>company_ref <span class="token operator">=</span> cl<span class="token punctuation">.</span>company_ref
                <span class="token keyword">JOIN</span>
            Issue i <span class="token keyword">ON</span> cl<span class="token punctuation">.</span>caller_id <span class="token operator">=</span> i<span class="token punctuation">.</span>caller_id
        <span class="token keyword">WHERE</span>
            DATE_FORMAT<span class="token punctuation">(</span>i<span class="token punctuation">.</span>call_date<span class="token punctuation">,</span> <span class="token string">'%H:%i'</span><span class="token punctuation">)</span> <span class="token operator">BETWEEN</span> <span class="token string">'13:54'</span> <span class="token operator">AND</span> <span class="token string">'14:01'</span>
                <span class="token operator">OR</span> DATE_FORMAT<span class="token punctuation">(</span>i<span class="token punctuation">.</span>call_date<span class="token punctuation">,</span> <span class="token string">'%H:%i'</span><span class="token punctuation">)</span> <span class="token operator">BETWEEN</span> <span class="token string">'19:54'</span> <span class="token operator">AND</span> <span class="token string">'20:01'</span><span class="token punctuation">)</span>
<span class="token keyword">GROUP</span> <span class="token keyword">BY</span> company_name
<span class="token keyword">ORDER</span> <span class="token keyword">BY</span> <span class="token function">COUNT</span><span class="token punctuation">(</span><span class="token operator">*</span><span class="token punctuation">)</span> <span class="token keyword">DESC</span>
<span class="token keyword">LIMIT</span> <span class="token number">1</span>
<span class="token punctuation">;</span>
</code></pre>
</div>
</body>

</html>
