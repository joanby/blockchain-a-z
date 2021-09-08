// Jbcoins ICO

// Versión del Compilador
pragma solidity ^0.4.26;

contract jbcoin_ico {
    
    //Número máximo de JBcoins disponibles para venta
    uint public max_jbcoins  = 1000000;
    
    //Conversion Rate entre USD y JBcoins
    uint public usd_to_jbcoins = 1000;    
    
    //Número total de JBcoins compradas por inversores
    uint public total_jbcoins_bought = 0;
    
    //Mapping que dada la dirección del inversor, devuelve su equite tanto en JBcoins como en USD
    mapping(address => uint) equity_jbcoins;
    mapping(address => uint) equity_usd;
    
    //Comprobar si un Inversor puede comprar JBcoins
    modifier can_buy_jbcoins(uint usd_invested) {
        require (usd_invested * usd_to_jbcoins + total_jbcoins_bought <= max_jbcoins);
        _;
    }
    
    //Obtener el balance de JBcoins de un Inversor
    function equity_in_jbcoins(address investor) external constant returns (uint){
        return equity_jbcoins[investor];
    }
    
    //Obtener el balance de USD de un Inversor
    function equity_in_usd(address investor) external constant returns (uint){
        return equity_usd[investor];
    }
    
    //Comprar JBcoins
    function buy_jbcoins(address investor, uint usd_invested) external 
    can_buy_jbcoins(usd_invested) {
        uint jbcoins_bought = usd_invested * usd_to_jbcoins;
        equity_jbcoins[investor] += jbcoins_bought;
        equity_usd[investor] = equity_jbcoins[investor] / usd_to_jbcoins;
        total_jbcoins_bought += jbcoins_bought;
    }
    
    //Vender JBcoins
    function sell_jbcoins(address investor, uint jbcoins_sold) external {
        equity_jbcoins[investor] -= jbcoins_sold;
        equity_usd[investor] = equity_jbcoins[investor] / usd_to_jbcoins;
        total_jbcoins_bought -= jbcoins_sold;
    }
    
}