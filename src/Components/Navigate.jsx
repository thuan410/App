import React from 'react'
import { Col, Row } from 'react-bootstrap'
import './Navigate.css'

function Navigate() {
    return (
        <div className="bg-light">
            <Row className='w-100 pt-4 pb-3 shadow-sm'>
                <Col xs={12} md={6} className="d-flex justify-content-center align-items-center">
                    <div id='Nav-logo' className='d-flex justify-content-center align-items-center'>
                        <img width={'60px'} src="https://www.theknowhowlib.com/wp-content/uploads/2020/05/Swiggy-2.png" alt="Thuan logo" />
                        <div className="ms-3">
                            <p style={{ fontSize: "14px" }} className='fw-bold text-decoration-underline mb-1'>
                                Kakkanad
                            </p>
                            <p className='text-muted' style={{ fontSize: "12px" }}>288R+8PX, Echamuku, Kakkanad...</p>
                            <i style={{ color: "#e78838" }} className="fa-solid fa-angle-down"></i>
                        </div>
                    </div>
                </Col>
                <Col xs={12} md={6} className="d-flex justify-content-end align-items-center">
                    <div id='Nav-icons' className='d-flex justify-content-around w-75'>
                        <div className="nav-icon-item">
                            <i className="fa-solid fa-magnifying-glass"></i>
                            <p>Search</p>
                        </div>
                        <div className="nav-icon-item">
                            <i className="fa-solid fa-percent"></i>
                            <p>Offers <sup style={{ color: "#fda502" }}>New</sup></p>
                        </div>
                        <div className="nav-icon-item">
                            <i className="fa-solid fa-bowl-food"></i>
                            <p>Help</p>
                        </div>
                        <div className="nav-icon-item">
                            <i className="fa-regular fa-user"></i>
                            <p>Profile</p>
                        </div>
                        <div className="nav-icon-item">
                            <i className="fa-solid fa-cart-shopping"></i>
                            <p>Cart</p>
                        </div>
                    </div>
                </Col>
            </Row>
        </div>
    );
}

export default Navigate
