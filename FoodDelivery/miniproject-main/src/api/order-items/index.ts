import { supabase } from "@/src/lib/supabase";
import {  useMutation } from "@tanstack/react-query";
import { InsertTables } from "@/src/types";


export const useInsertOrderItems = () =>{
  
    return useMutation({
        async mutationFn(data: InsertTables<'order_items'>){
            const {error, data: newProduct} = await supabase
            .from('order_items')
            .insert({  ...data})
            .select()
            .single();
  
            if(error){
                throw new Error(error.message);
              }
              return newProduct;
        },
        
    })
  }